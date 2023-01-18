Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0087C32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 17:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C2910E7BB;
	Wed, 18 Jan 2023 17:28:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3087510E7BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 17:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E09WoID+wQIxEjia1DNlvbuo0aVsBm+yLRfOM9NxyKosLbZVV2B6eGS54Lf4lcnHw8gi73WBsXO/57yyShzCeCEB6rU3A9/AgXfCtgUbhxavAVhvCsQCQjfA6JJ6kmxO4UFueny8QLBcJPdwUoupFhRIUw14k9z7XxccyXBO9FvO9OfpumGaDT9Lh17VOGrI7SPhO1ngHqQAGQsKyr1DozCIDQ88lcqTvq5/Tywct9xKJyYIkI4tfQ5SRNWmcfT/LYF7zF3y+HOpSnTxiKZHVJyuwazDx/JB4pjIQNkjY4NrTOLEnsBPVhK5iDUZybKB77IEuK7J5YsDbP6hiSrqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy8kJI+irpFAzl0Sa0sQrh0At/YZGw58pcVfLuwv01o=;
 b=gk8t7Eehv4AMKzUFRqLghgkL0z2jGjrWxLCm0OSWp3cO2sCNtUeYFBHrLpfIMc9maqqnF91aAB3k7O+IGBbbFQmNqvPwmIPo40PxwSAvioEqf+w+3QmUTmgXMdM5p+lhCPbHk/JPFwHJEV6tqKdAAx3bGIHmZiZXINwEr0m58kEfgRFon8sEWCCNDzGJ0EI+oB0ZH3Ha1NgXyBWxbrihNSWX9+fQbrS2WXBVRnErNMAUF2y7Kq8MO1ezMpw0tPLH67vMA/JhtP0aajJf52roRX/8Vb5ZkqlScpyenVhHoFVugc5wzSpdUEEvNJQ+3DuHlYWLk8+dAokWOTyt58nbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy8kJI+irpFAzl0Sa0sQrh0At/YZGw58pcVfLuwv01o=;
 b=HmzkdggkCswDID0GLm1A3HGHdhUsYQsUX7Tx+YG9MIUzbEDgLSpFo+bszhgE3sHdcKfHEdvm/Y+iBQKy7rrkXijgyrPpo7qoWNjMvlR1e5XXk3Z5vYgkrhkayFbpz8h9QYE3wg7R46m3Npm2TlfkLdVLHLd7mxFAF7zt9LAWxEI=
Received: from MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 17:28:42 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::ef) by MN2PR13CA0007.outlook.office365.com
 (2603:10b6:208:160::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Wed, 18 Jan 2023 17:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 17:28:42 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 11:28:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] Documentation/gpu: Add Raphael to apu-asic-info-table
Date: Wed, 18 Jan 2023 11:28:41 -0600
Message-ID: <20230118172841.5690-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118172841.5690-1-mario.limonciello@amd.com>
References: <20230118172841.5690-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d95c50-8b20-4b58-2d6f-08daf97971e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6+GyYLNkiY8Srgk+d1uCxKZNoA9CoPj93U3xPOQUzoECqhcmuuBTShIb1ha3x3TZPoTpjDzevkhXBY4PCM7MxwIqS21UGXJbXcNiqoOxtnx+qERswccfWsuM8+ji2+X4HxYBvMpDCd5mPQboggePsKFl4QfgsHRCuHktZfaIfpVVAkxWop2dJtYtvY+1BTAFtDrstYUOl/u0UpwI0BO8E0GQPgjyaejKDtGP42F9pBD/RyOI5asU0YAiazPamz1p8qKuFjzDOm2CQhMcdVO5+Vvymdnm3mmSO9l5i9kzmnH6mPWlLx9wTvXbcZekxeA3Ld8915eLoFTQzREg09L2NFbE20Cz9C0mipss6a7UaydqOoajzkhsz9cAUeoXpUreXueX8o+4BU/LbmceQLIUMYsO8MooepdacvbwsZ+aMv0ADyQO2oO7LMl3/phelLAK2sNeb+LAGJpHoBRKPYyz/6IRlHrnrFBINeKLxp86iq34Rug0byWpb1r0GGzpRbBFyr/D1Ee3D8UYx3nNz32y85stIPlnjcyBYk88d+ASZvdajtMU7Koz1jrUC2W80gpiKwqQJ4AoGjutdDmasdknl+Ac++9v1kxIWok+2NT4ChMlpZbU3ImwPDtHhJRyrpmGhE9//3CdtAia2KTGXhluBpAcRFX+H2t5CKarTVSuYDLeOK014ytS4PPKHamMmgSoDvq9Xkj4BnddNn4Zxuu3ioG2mlEaD1KBJl1Sq8XoEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(82740400003)(47076005)(40480700001)(426003)(36756003)(478600001)(2906002)(186003)(40460700003)(316002)(26005)(7696005)(16526019)(1076003)(44832011)(8936002)(86362001)(5660300002)(41300700001)(54906003)(6916009)(70206006)(70586007)(4326008)(356005)(8676002)(81166007)(336012)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:28:42.3343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d95c50-8b20-4b58-2d6f-08daf97971e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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
Cc: "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Raphael launched in 2022 but was missed to add to this table.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 88f4e3071e696..395a7b7bfaefb 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -6,4 +6,5 @@ Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN
 SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
 Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
 Ryzen 6000 series / Ryzen 7x35 series, YELLOW CARP / Rembrandt / Rembrandt+, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
+Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
-- 
2.25.1

