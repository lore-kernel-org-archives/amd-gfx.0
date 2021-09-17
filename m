Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5989EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE73604E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2EE73604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35CB6EE8B;
	Fri, 17 Sep 2021 19:26:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140416EE7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRDp1WlhSzEJb+mC+YXPlDB5syZmLhJtL0NmjUxBGmMmdyK3tpLldHSFcT9TyJ6UuD+FeNryr8luqHQ4tgbuI5o9I26mIKlpBHiKzWmNEfoADrK4i9CxrWracYjrNjB5EZDR0m5mboxRMGor9HAPjiLkdGeu3EKQlUmpysckb8dslgwORjXLQ3pFaRrJL8o3EhmY9tRhMW9R4p35hhMLJQWQrZ7IteLKcltMLfXBWrktWYEMtsBdSBY7Q/ywYg4MTtSqVSqczw6bmZ7KfO+FLuls4UmtdRFgJZqERverGxyC4JrJYaXcNIVh1w9VplPBBfpZB51EMML/TgGVaH8BRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lwgn+rykrCtTqjz2E0v2pZkCJyoebWrRjeqLf2xGN1M=;
 b=IdykzklnYCgbUQdgy1Ui15i/fPFo0VGTffYo0k1Q0jPwto7sW6NAKL3LO4id1a6cQc52gsj65HJOKePqwMBkLXm49YKvsFTdgqiHUkZUTuCXh6lh+Hv3/5GJwnA9U6JnDOywCFlCvYtNioGD9M9nu98GNRjDOa1Z7jjkZ6jh766SsGc4cyXG0HV0rY9zSrc79jj6w4QMJQspP5xHuS8fkyFb+WIiGecsuYh41mXihrF3da/Jacm5PEhfJC5LX9e8E42XMoYCUGf19V5BF6Sn0aAizxSCnchFAk1Ro/sS3IFzLxESNq4reRI6hNSuW77yGofTVColzkOCu7NF8pyBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwgn+rykrCtTqjz2E0v2pZkCJyoebWrRjeqLf2xGN1M=;
 b=aLW6VxzBpMocM7q3h/2aniDI2PKRZHXMR1UZdN3k/JeoTBXyGSMN6f9zccPd/7lZevmqWctlh6OdSrU+0UD40O5DcBlDk7CwuLGRt92ZP0t4QDJexEgUS5TwbU+PZQl6SGZqpQtp69FajnyOfZbAj+AhiyjfbJHRMpWvu0v+5vg=
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:26:03 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::ab) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend
 Transport; Fri, 17 Sep 2021 19:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:26:03 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:26:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 17/18] drm/amd/display: 3.2.154
Date: Fri, 17 Sep 2021 15:25:23 -0400
Message-ID: <20210917192524.3020276-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ff5926-c2ed-4e09-71c7-08d97a10fd4a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5211388A6645BAC65C7A69C798DD9@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7RS8Q0Ya38smb+Jfk+uxXEJkBamzA0vg/sQ3I/U2CVbYYfSjrYmogK7N5sXvv0Z4VS6t6CyqmR/pBypq3mBtoz7NGd+XV6uUrp+wpF5dQLTA4aIcznX4C4i9SWF51G+mhJfh3c07POchvIh+E1lcs1B2QkVMHTpZJ3KJehsqY4MIUbPd6FHrBCNvWFq4ATEEsrAYvhDWaV/3onb1xsY3bfC6oY5jq6FPeUjg7DB6Gueb0hAJ2h2yTduM9ji6spvX6KBauT5JnmIzZz4lOdGiPnIXdZDfmczmtMzhYju56gdSy5665qw9idaRV4kSsiOk6Os5ohVhN/1bskiFcOlrMMy3ppHGx08myKou7E42efLM2oS1F73D5U2G4m8HdwoKZ2yvtxotNXM1qfwRWqlbqxcePLsDt+E5MKOvrF6ofrcm4hvBXhbYU7fzHlz2Ji3sBlc7M9g8SMwsRSJu4hglmqYbyxEZXYgPtgKwjI7U9wkCM6GZ1dzmaKao9wh0o4/dTY1BGbl1jOLsyUxegHrxOUJR8tIe25+w8CiqXinaPFpcvZc7Ez0k6ZOLy3E8V/iwzCxbEWYQLS3h44Y/tgheuOYx2e1yOrjbDqKpFMoj+AG4/RBe2Z+mNGJt3z8XvrBNkXmnM3mQCN3aW0hV5shKo9HkOwLI1u4oqLTIJeOyL3eRSD8/lUHnrn4ZXc7PIZiiqHb6hMEKxkP0v8wQGYLG8AmZKhkwQaYvNV5KCblE/o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(36860700001)(4326008)(8676002)(4744005)(8936002)(316002)(5660300002)(81166007)(70206006)(70586007)(356005)(26005)(2906002)(16526019)(508600001)(1076003)(86362001)(54906003)(6916009)(82310400003)(186003)(336012)(47076005)(2616005)(83380400001)(426003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:26:03.6775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ff5926-c2ed-4e09-71c7-08d97a10fd4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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

From: Aric Cyr <aric.cyr@amd.com>

This new DC version brings improvements in the following areas:
- New firmware version
- Fix HPD problems on DCN2
- Fix generic encoder problems and null deferences
- Adjust DCN301 watermark
- Rework dynamic bpp for DCN3x
- Improve link training fallback logic

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1306dedc1a98..e5dcbee6e672 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.153"
+#define DC_VER "3.2.154"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

