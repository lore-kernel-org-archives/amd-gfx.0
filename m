Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48593C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794916EA6E;
	Fri, 26 Nov 2021 19:49:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C8E6E876
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDuxJYkLU+yAWwbdimygGkhaR9+aS986smlRWR3RsagbcVmgd/wcWqEGBKOZQRFf9qcHOpVNGD2/kC/wUBMzc3OZK9M9vHjUTqqWPGNAmNRvx1ULc7R2/uLaUt1C/3LrmGydbwIweo4o2IJ/cm/cUqgD3X8AzC3LS2N0gn1PSqOgxC84IsH/+OvS+lygRLamKsdJXuctXiaONckbtOE1nvWidCETe8MCYqQlO/VWDCrygsWILvGj3zbuB4xz521u3mQvbJLbzAxjnlUGv+rccKRQpw+cSkqvVDjxfEHYWbZw3i2U7fAOgIbUghX6yXMfhum6uf87SW2p1SlAaJmfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS2eyY/UMaU3K5TpghBUWVeh97Z3YNE4CLbbXZxmZ/E=;
 b=MMZ6ZlxqqtQf4UkeyU6J1it7Ioh+iIAGhTj6tNvU4Vypr5HkfFrBlRujvYIYFKypHaTtr2XCsPWDzWAj6s0xfy8LmOZBLYgxU9crgpp988N2OStUTFv68CLA+5HaEfcCBcm+V43bN51iTeG83fKDa3Gsw8s3JOgT3PNO6NtNKvD821ZlxXvpqHZZ/Igmogbw5YzMTBQD4jiRiBFU68hH33oANfNdIX1nhG7sjRqPBp1WCJRaUiRKhU7Kl73LoEcsbldz3jzPmfEwCp6HVEv87AvAYHpOxAobxkY71e7oD69ZMjQ5fvF4xHp1zLrDRcBT78PKR/TlSIgSQ4FzAlA/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS2eyY/UMaU3K5TpghBUWVeh97Z3YNE4CLbbXZxmZ/E=;
 b=mTIxs9C+BVACvkRYB/wW7CrhdGFTiheg2XrwBbZvClJiIxF0vDeZkiDxp1nbORGP+q6wv6kCaBcKYA8uWWKtHOW1CAUuckhEhhLtHteISxhwvQ6C6JhEcUs9l4A/voeUlVMJypwzmw9ap2wdHDINAufsd7/BEE2IoHQYDxkJeOg=
Received: from BN6PR19CA0112.namprd19.prod.outlook.com (2603:10b6:404:a0::26)
 by DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 19:49:38 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::4e) by BN6PR19CA0112.outlook.office365.com
 (2603:10b6:404:a0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:29 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:28 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Clear DPCD lane settings after
 repeater training
Date: Fri, 26 Nov 2021 14:49:10 -0500
Message-ID: <20211126194922.816835-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 659c980b-7033-4b12-a094-08d9b115e128
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3291EAFBD22A5C9FDF59358BF9639@DM6PR12MB3291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe/HylWMHDzy80JUdmsPtBfKtUw7rxGdRKrWzPOmKrTCv/sNkLSI+aSQGqpumcHAOEwGSy78tNL15qUc2vSxnrqIwS9sGhdraWfS49m7Uxj//oyujtDpSLq4Fk3FJcxwJOTNgF1hjC3WKh3HtkkNg2wzEWzduqsLuwVie4nvaC/7riKkhyGQL/JDUujpr84/VGcj36w8I+unzHW/H9ZTqTCi4seA23wam74i/ZcN/oo8ljHRPd3Xh4R0pIpMkmP+YJEje9h9MLVuUYxaCUaZQsvMoTVHmZ9RhgZGE1Dh6nCxOG+wBJT2Kit3s/NdlsbG2hT9sSKrwvrBPpjy1TBd7jLZ0ar1YN62kB7sVc9++dxveXtWsvVrI7/JiQfhWWyR7wyzSH4GpGBuhfFSeFv2Fr7qmvQngXMuahnXkqLsvoPKljYQu/paFG9ON8NDstx4IxIxmgSAGbC5ixZElK+rR15uqMZgC6icgZ7VZbKWczHEzqKUM1TZ1VI0quHhS0xd7Rr+O1dC5D2PpPl0SDMrxsR1jxzhGv9aB56KmsLfrYG19oxUluI0PakwwtEcTPuaGOwC5z/ZbkY86Le9zsu+7TryC/2OXsiG3rLMtjvcdkdCzqsgfj2fEQjThQUxP6u9y0otRpG6g5ZAak/lcOTt7Xo+ss4GtFK9ZWnOzqlu721nDH7w4SNBa4sf1m5oYLbUO4t/eCax0sbY3aJANBp82b0YWt8s4Q+H96J0W4EJTyo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(83380400001)(2906002)(26005)(2616005)(8936002)(508600001)(54906003)(81166007)(6916009)(47076005)(1076003)(356005)(8676002)(426003)(6666004)(86362001)(36860700001)(70206006)(316002)(186003)(82310400004)(336012)(36756003)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:37.9001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 659c980b-7033-4b12-a094-08d9b115e128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
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
Cc: stylon.wang@amd.com, Wesley
 Chalmers <wesley.chalmers@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, "Shen,
 George" <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Shen, George" <George.Shen@amd.com>

[Why]
VS and PE requested by repeater should not persist for the sink.

[How]
Clear DPCD lane settings after repeater link training finishes.

Reviewed-by: Wesley Chalmers <wesley.chalmers@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 84f3545c3032..297553074bfd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2138,7 +2138,7 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 		}
 
 		for (lane = 0; lane < (uint8_t)lt_settings->link_settings.lane_count; lane++)
-			lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET = VOLTAGE_SWING_LEVEL0;
+			lt_settings->dpcd_lane_settings[lane].raw = 0;
 	}
 
 	if (status == LINK_TRAINING_SUCCESS) {
-- 
2.25.1

