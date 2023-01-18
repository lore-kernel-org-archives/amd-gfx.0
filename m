Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBB0C32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 22:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DD210E85F;
	Wed, 18 Jan 2023 22:47:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD7010E85F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 22:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ues0Uci7W8J+9w3G4S5b09fUxL5sJ6jmKfm+ftyovf04B0g+Zcqg6+tQFpZKblUOpZOdHeVmVz5HcjqBvj0rBEZJKwvfuAQJEexmuo1l8pVjdeQaPBovOdSareKyOUrj1Qe3Q/7L4yoIQ00u0wsiEtLcQGZvfNteLnSaqNemHveytLVgOh96bEph3lht0G6qfO7LrUnCpDKqIF+iMdjPfXc4AOvTnXymUUUvv90xaxDOf0XfahqTkjRU62QbLOdR9MB1zFhWw/9PGJ2QDsAyD1vfUT6bgJl3AbW6N7GuCXtpWGkpiLNSNXrtw3F0AbacKXbagx6V1xi+3TCd3qUvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+q1hs3/hnxbDUyid87RYudTdEykuKSAmaJrwWOSOfw=;
 b=K7TsMO2kw9qHi8PsSXzSPH/wKJaU75T1DQH7duEvj0e/6sQS28QZIizHjr35srnemt3npEkuauQCSjT9rxW4j35EIRX6xbtYTJ1C943t1o7yYak6FR1LYijarEfJDjpqXOHaVr/q6sLO3QzGq4IgpHbyWZpvIY6LuFxsRyWpNtHidEclwuxVjvuWzmV0tl+YyvqkYIo0MSXLPXF4JVZ2ihgi0KsOHAy7VnSKTtu6gznW/td+GbPeD9e1tVhZQaVr72GVcMQglzhWb9zvFiBj1MJ527tKtnszz4nW/vGtFB2tTUvmJa3uvVOlZ5p5eVzsFVMH67tqPL+dS8OGJGZh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+q1hs3/hnxbDUyid87RYudTdEykuKSAmaJrwWOSOfw=;
 b=09Ct9PM5QLyJbJyLCAZIdWb3pfI/wNdDbsTBCvry0TfLzvkg6vSyIiXazIJRwNqWyUVMixegEj5sKeNZVTPvbLkd6y8Q3lBMTaByEqds0hBPutcmESwixKdvYl6hO0ApQWUGKSvaO9VIuxjVe3Pp1CDdEgoLmoG3k1BIz1E7t4E=
Received: from CY5PR20CA0004.namprd20.prod.outlook.com (2603:10b6:930:3::17)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 22:47:14 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:3:cafe::21) by CY5PR20CA0004.outlook.office365.com
 (2603:10b6:930:3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 22:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 22:47:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 16:47:12 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Quiet down some warnings on laptops
Date: Wed, 18 Jan 2023 16:47:08 -0600
Message-ID: <20230118224711.6832-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2d59a1-17ac-4f86-9583-08daf9a5f143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS44tfWXYwXLTRIkKCTiAGuSu1FtH8A0DHhCi5AizoD46HdJzE29pRegRqKjywvR+nNGEWUB1kagw9LhHjeGAvG7Hga0CIuR5w8FyGD2WDMsTmXNyfqz9Rl0OaArUzRwqb33QCWbx2rIQSBlNpuoXf0pG0ig6A1IImjcCyDTU+4ctmUFF6aWtorrPMDjbWS0lhhhLIdzdXiU2GzUIsEHVWXHgBxV5TVb0qJiVE730kCp+ntp+jBxTGKN24wZnh5fRFFm8aOhEEkNWvOQwBeQXGjnlhZtua8wt9g+24t705Psyoj18d8NTiysY3oXoKDwva3IZS8+HTLc+SfnCe2EZcOF2ugzUpdqpDQp6w8SFlw5zZ6XLP8tNsRYUncdWGuhJFW6bUdRgcCuO9wWoThly22jbGkFOZAqEeotDwJHz4Pe+bvcftaWfjui+AEe/bFsa1BKjhU4ITEbtf0GiCO06SSrZ//wFXq//58OCguvudmcRaDZwSEBOundnKxn+3+u51Pz/ttGw552GA2D25bb40HJ8ZOoWu5t5OTGx8r6Y2z45uJQThXfD8oOgqpwJlU5Ei3gBxRholsoPiJ2aRjghHLWXN2edqEYH3vDGGXl31lLAjLvF/bhFPPQU+TjYz895zLZ9IHVp1VvyvkpdhlyR5k4jbCRBTR1SiNyp3XVNqyoybWLCN6vmwgIVKzQe3Xmzsyo/gk29gGpOuV9/24/qnCKdJ5ky1GfsoWsS77IJYU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(426003)(26005)(478600001)(82740400003)(356005)(81166007)(41300700001)(47076005)(186003)(1076003)(316002)(2616005)(86362001)(40460700003)(70586007)(16526019)(336012)(40480700001)(7696005)(2906002)(70206006)(82310400005)(36756003)(36860700001)(6666004)(5660300002)(83380400001)(44832011)(4326008)(6916009)(4744005)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 22:47:13.7911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2d59a1-17ac-4f86-9583-08daf9a5f143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looking at Cezanne laptops from a few manufacturers I've noticed a few
harmless warnings are emitted to the logs.  I looked through them and
think they can all be decreased to debug.

Mario Limonciello (3):
  drm/amd/display: Decrease messaging about DP alt mode state to debug
  drm/amd: Decrease warning about missing SRAT table to debug
  drm/amd: decrease message about missing PSP runtime database to debug

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

