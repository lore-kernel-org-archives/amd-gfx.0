Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA3FC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B14C10ED5A;
	Sat,  5 Feb 2022 04:33:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8894E10ED5A
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMvJkyERWUvowS8BUrZzeKtgL1EOMRKnQpCRIFvmbThEjxbTl1TtZ83tPkIlw4tyjFEtB9esogu7sOMHJVDWBPiCll2y5MEbrojCjzwxosb9PF8Y083RiiSGkKnX7zwCpCGts0myO9S0rPfCUp/O5XHT3Qf2tIrz5M82xyiuKczqxgkwwQUyn3qjUAZFjhFR/o7ngN0e9Z/n8WfzoSDDSwcGLXXb7bDcpjtW0nEzmdS4tZDOUOwzmDcJVgvRlSZ6WGRQG5rrF2CAzNSF6ra4LFTZLw1SlkPXhRbopyq4vrwhHX7knIRPrSDgPvFMlTqE5yRkdtgYGMkVAnimCrS3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glH4CXE+z8NPLu+7+ekBuy9SoqToJ5XwYKCIi5ETN2U=;
 b=XwwNjI0w2aazYqB6/UZhgrkvsBnbwyjnVAcmef/WI0UiD3GjQMMJFKBzx2jY83UvdV+3UyXN1xm0mjHRj6q+W2MR8tOEJbmK6M5oDYtQgo1nUMzzsSka+iKj8TOlx9znnybL+JMABdPoYDbJb8qBK9839PJ5W2MtOrOBnjv3yIzx23T8XNMBeYUdvHG4cTFZtStcY0KRbpHtWavwaAa44VhYuLcYmrv2/bwtsECF42rK3J7wgv7Up0gczQLSfu2qnIclBCdqUVAkuB0/0Io+UP6Db8cS/ZoF/sansfPJhL3pHnG06ceMZEdKwxgbDjhExDzud34w2K+b/9j6GBhfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glH4CXE+z8NPLu+7+ekBuy9SoqToJ5XwYKCIi5ETN2U=;
 b=UDE1XDKvif5+u9jjtFFyqbfjc8lzmkA8ekZQUnYOUKtnc8Z4jr8lH/08iQp3TBcWmTgUJ37gngRNh8RPmgBjIBHCbZreyeD2EDQ0vR70HO5BaKLu/kpkqZVEu5AoD5J37hnubDC3LKVPUUjEmBuRpxAlcDGiVoL86rhjO5CCmNk=
Received: from MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37) by
 MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.11; Sat, 5 Feb 2022 04:33:36 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::90) by MW2PR16CA0024.outlook.office365.com
 (2603:10b6:907::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:35 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:33 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amd/display: [FW Promotion] Release 0.0.103.0
Date: Fri, 4 Feb 2022 23:33:07 -0500
Message-ID: <20220205043310.165991-11-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e890cc8-af7d-4a58-e6ce-08d9e860acaa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3165:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB316588F918E36E4966457605FB2A9@MN2PR12MB3165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCjqObisKxzIfQXhzu/3B708K1jTNqAxdN0+grE18HNvV9POqSgUnOQ0CN5ZwbrB/Mn1qiXA2fAzABF+v8Kh20r0H2QOGOXUsjSlPATZkVXvl6E0Jf6lWx0RlhrjB7an2OwOg0YJoT27EVw46AAYTDEYjUl3QBSmIWHh6NfbdoxfZTRM00ZLa60m9QxjwqSL1JJzZluQNgZB+/BJUDiDd4FjVhgd5OQRk4geecRieZgA++3NLZ8kW6hG+omAztcnOMR0LCWFvp28xR6y+WYtBd75eVQoxpLoaKZFZXJ2cGpBaIPZX+mS7VnoHjk+eyG2JmWhmCZQBAKSYkoGRdMvI6oD3JRVTi7HOA3H/Yyn3J/3lzxay0ddNk6JZveNq3ilsAJ0kwubth8EHBUg9/JMaqy5SVHIiTSrg3cAGZGlD5gR1jnf9dUuLIndWQ10upZtoiwvnZgJ67zrHxvKuTWTj7yoVmXRIqmPOJOnRifbs4LRBnLCzz6dCe7dyRE2UnOrBtd7Rb7iNb0AOWVisIMlhsUYT5xECmxcUJKzY3fdPCdZtwpl229694qw6qZX1gzZjvAL99dMrY4kAI5bsi1sL1jbj1aEaKS9prQ34xuk1P5x6EjcnLTss6HdsdWgCZUBAAOFyFJjIKbhlBfBZnhMKTY+ykmf4S4gNOOq3XwSFxCF0fW8Isb46ogIWsSt1wyvKAh1ZahxDT/K2wH/nqLoQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4744005)(508600001)(2906002)(6666004)(36860700001)(47076005)(316002)(40460700003)(70586007)(4326008)(70206006)(8936002)(5660300002)(36756003)(8676002)(336012)(82310400004)(81166007)(356005)(54906003)(83380400001)(16526019)(1076003)(186003)(426003)(26005)(2616005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:35.9146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e890cc8-af7d-4a58-e6ce-08d9e860acaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a01814631911..c5cbbb0470ee 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xab0ae3c8
+#define DMUB_FW_VERSION_GIT_HASH 0x5189adbf
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 102
+#define DMUB_FW_VERSION_REVISION 103
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

