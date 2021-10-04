Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667CFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283DA61029
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 283DA61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922A96EA10;
	Mon,  4 Oct 2021 14:46:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822026EA19
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ura4gObrHHm7MoPFbfyYCYIcSHp5vkRhAYE4k9z3ZQz80NeEl4e26LrnQUYPMe0MB95Q8JEM2CvmqqqH/vpHqsmhbDSZKRIX2Eotkf9WlT5ZS3JN/Ym/SUj+xeIG6V67ajAx9vhaEvmgTsg9Fv7Q7koI7meyt7ehoEiox2BjY7c4aL4/D+C5QszxsgV/8kkiI0ecCdJdh2nsbgIFWflBmxI63Z/cX7vlfvMVJPdSjlfbYlMIYN0P5xga65WvQdz4sQ5+6G3o2dKLK27pYSgHlWY4PQC07nwWkR7bEHnrYCYZ6Xt+PoSm3lELiiaDyEKQCWA6jEzKbYQKbWbqM3HC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgnWkr4YPdXiBUZw8/4Q4ptIwbpvbcteSmZwkEhRVD8=;
 b=mlwj+ezWV9UNJ2oPmQNy9gfOyAzmT2Tzk8EsEu8+rvJO0DaHS5hupO6+tcpLQUs6q6GkVUO/Sk8qXyAzJTuMbZnx5nMPjcmgm9bXa+7TNfrJXMVaxqEDDdHZbkqjT65jmpsQAnzqhPzpAg8m3AjaZ2uIfQFJRwSliInB1Wlk3bD8vs19xq3rMCQYMi5tdqNIGiN1hoI7aDlB/rrx5yQ6diThONxCKHu9i1+oNu3bPfv7ET+YKTNFtUwDZpEclPU7DTm6zaluQGDf5Dtsf7cocs8nWb9Gw/ndCU6+EV9g5BqM1kJ/FCtCDEF/atOClsCwb7J0SBP/tk1rtWQTz3juuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgnWkr4YPdXiBUZw8/4Q4ptIwbpvbcteSmZwkEhRVD8=;
 b=NuN/SwYElFf3sjih41NMQ9O/6U1PZgIaDrWFGGwCrLijIJVo1dZsQRje49nF/Q5D8CputMeslnTBeR9X6Ragare24xYD9y9gpoyRrkyIAPwlz7p3aMb6/P8dJ+ocYgol6jHZ9IB/rI0uCyMT0qZFqgVdt+lL+kVaj11LY+UHWVo=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 14:46:31 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::78) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Mon, 4 Oct 2021 14:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:46:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:46:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 07:46:29 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:46:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jude Shih
 <shenshih@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 23/23] drm/amd/display: USB4 bring up set correct address
Date: Mon, 4 Oct 2021 22:40:50 +0800
Message-ID: <20211004144050.3425351-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e064b7-f576-4bb5-7a2a-08d98745c0e7
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:
X-Microsoft-Antispam-PRVS: <DM8PR12MB53993899BDAD87447B699502FCAE9@DM8PR12MB5399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWj1XspONS0oMLBBR+HmCuf1b0/5hcyufYVHv0WGD5qpfZI1frkCusyoMPkO9E+csrOFCb+zuFLHpYifJG4mCJn8s8j9vvlVrWx2OCxtH5HSWxWGIs+zbcOaG54/A6o6kNSRG2wSMIzsA9H1FPN1BMhLV8NtpgHMviJ/K4PLAFNLh3mS7thH7sSJBol1NdTEuFIhf02X3cdv3opsNIlHTTpXWUm69A7OW1Fuk08IoKEQPMcfEkC4AHoPm3Wgj49NlT1jlqgnQ23BjOHrOLY1zai8yrVp3yvISyOKBBZxAsV0P9PB8kwJEQN3CkOYsRg2wwwDZtBtC1/wDOHoRX3tIDV3JPlTJMb03ULYWG98fLxd/PKPw0waFOy70zQ/VHNWIqon7j9aZqK/HpGSZaSHweOFhycHLFfIpI/kEVVhlqM4re8Q/xc8nWC179RtxfGngcrs8NG92sbugimG8LB0MNpF12nlX2aV7usny/625DhIKAgUBwCQGJWAs/p6Ms80TyGXT4VZQSYSIvZ0WJjtGbVvIeb90sae+iqLndPVVgKGnyOjSfL+ZbGoQ/D9Vk+TlTGRWUsWbOA29o5Tdh44tHO3Z+46abtgJG31ztcTdxu9rqkjVgmhyQaPz5gGzPFCRShoeL0X15XNxc83hGV0I2yqrPwMN65gTH2WCNSBBd4ta/xQzgz7UlP33KlsZeDqksSsVZbLpiNEv8MlEFc/sRjhiVV2Leq4DFkH2zgREHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(8936002)(6666004)(5660300002)(8676002)(2616005)(6916009)(70586007)(4326008)(47076005)(86362001)(1076003)(4744005)(82310400003)(426003)(83380400001)(356005)(81166007)(70206006)(36860700001)(2906002)(508600001)(26005)(186003)(316002)(7696005)(336012)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:46:30.6995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e064b7-f576-4bb5-7a2a-08d98745c0e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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

From: Jude Shih <shenshih@amd.com>

[Why]
YELLOW_CARP_B0 address was not correct

[How]
Set YELLOW_CARP_B0 to 0x1A.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Jude Shih <shenshih@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e4a2dfacab4c..a9974f12f7fb 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -228,7 +228,7 @@ enum {
 #define FAMILY_YELLOW_CARP                     146
 
 #define YELLOW_CARP_A0 0x01
-#define YELLOW_CARP_B0 0x20
+#define YELLOW_CARP_B0 0x1A
 #define YELLOW_CARP_UNKNOWN 0xFF
 
 #ifndef ASICREV_IS_YELLOW_CARP
-- 
2.25.1

