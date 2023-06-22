Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0ADEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 18:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F7B10E59E;
	Thu, 22 Jun 2023 18:25:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E17B10E09F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 18:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM05f4sbjs9xdrNGYfGjy21tsL4fHkLFWTl2KVC7srwfaaqaeJWf8X62lkWj2GAzULKF9G4u3EbbHjytvfsiAXU/MqzajnpPuT8UCwqE2Yyg2npGrGtqeYgI4q3r/tHNAWVpWNqbcdiXfZg2p/Jwq6qw1INX7vLQy+Uthq8NW8HyeoikprpjRkiAfQ4kSFpKsjSgupSoZCjMTdLLc0cULX5mlbYhE4IlFyRcHWSOEn36eNxqc4Zy/At/5ymrnkST+XZ3HSIWfExvra78jJRbtZXaKNyX8WCEtZMPA3rBoYYkfqoGCOiAtN3l048bxu5PHL5b/sc9dVLR5NnmmeDZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZnM40t2oeON3Y43LTEgFKOrTHkbPwxEJ6LQDz1WlGk=;
 b=NTQb5K43tT3apWjLFVA/EXMWbp3c7+BsbysFyq8SIBLgkcuGd1IzsgVa7ew/FHJQjvZwdu2moMTH4YGJjMlU7e5zV4pRiK3vVqf3hkrOS7aa2+b8GOBsCb5lUO62E5k+Bm0ZyUMNPydvsPbFUonU/6LUxfVWIDkEFLtSIfeWVMmOkAXU/soD96uI8o8dhBjK9RBPUJBUHA7CYG6xt14+hY8tHL6xloT3o9ZFGAR1FUhR6x1Clcu9VUir0kI4DZ5dsSXh20q2LCSpo6Y28cN3wvyT++qfXEy5MewBzno9eNNWjgyqOwEC7niJcnYNDdxE1cF0lVz+rFMbtOHrOoXQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZnM40t2oeON3Y43LTEgFKOrTHkbPwxEJ6LQDz1WlGk=;
 b=MRofjG+Cb7EFI3xHoGqFyov8mvsc80moH8FJzVY11VCgGbE2bbZP91pr60VkDl6mLFbyFxnDfe2g/HDn9e1heUesQTV4WDkEY/Q6GtBz7HQp8e0nFPI5BpSCjWJ4PRgY8mu6mk7w1nsL0gT6sF3pTfqFDhYL6NBinkKfQy3u02M=
Received: from MW4PR03CA0314.namprd03.prod.outlook.com (2603:10b6:303:dd::19)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 18:25:23 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::97) by MW4PR03CA0314.outlook.office365.com
 (2603:10b6:303:dd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 18:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 18:25:22 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 13:25:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Add checks for enabling PSR-SU
Date: Thu, 22 Jun 2023 13:25:03 -0500
Message-ID: <20230622182507.25531-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 2865ae47-65cd-4d27-bac9-08db734e0ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRDOF6ZBQnJ5ByUeoQlVdk3K6r/u0jN9CuCSXz8ITEAk86lRcaAMGBwv2INOio+oQMVA/htAB8U9pzfM9GaU/edHWdMKOdzB6NEHwK1hl8iO4UL0r9zCXIe5R5hmSYmJq1VZH/w2c+b6DfFevep+huy85gOT6FmcmP820BbOOWwrHQ/n97eQy8Z8Z81mrN7pYLvjXn6wsJSuM1KsSwEon0VLSi2fLNA7ZsQNG8y2QPmmn6zc8xLdtToLiInHEyq4JcAFRmeY0fyHPAECp2BZ9H7xmX2ERIAQLAvxq3EDRYYTkwfbETZQFn7/EgndonudMMF9czgkLlELU5aXYu4Ui2EyyMRuDqqnk81iky+W4EanhwF9A1dlCN5/CC1FwJnkkXRwOOxufxgfbcogY3sL3ZxO1eN+j//6Pop9stW4Z6UraZAU0fpzGVp0+JokQDxorbhsuufvZlD8WCzF8usfxxs0B9dE1evBEujYPCtJAoyZZqoQCLnY7/IQ8W0S4phjSzT4ig3DySdXstQ3V4zIhYiUcdHQW0FWAGmUJZsF9gwaz0Kr2ITXaTiCdV9ydqxQkUUFHTK3D5/VL8/DDyi08G1ZxTbABVY0mXut+daf4g/MG6t4mGaS++IRE7IpqFvkFGy9r/stLLTxyvUx2PzgRlN9hB9EJZpXDANU3KC30IJvJOMySO29a4sAsntzb4O4RWYuR047s5l/7fW5lulCPsPZUBVnAzSO+O/5jIEU5iWFsVD4wKoNwBzR61hKRdjBLI7sHdbb7UH5cyWAbo5eyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(356005)(82310400005)(81166007)(40480700001)(86362001)(40460700003)(316002)(2616005)(6916009)(8676002)(41300700001)(8936002)(70206006)(70586007)(4326008)(44832011)(336012)(5660300002)(7696005)(426003)(1076003)(478600001)(6666004)(54906003)(83380400001)(26005)(186003)(16526019)(36756003)(2906002)(47076005)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 18:25:22.5951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2865ae47-65cd-4d27-bac9-08db734e0ab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There have been a number of field reports of hangs tied to PSR-SU
specifically to Parade TCONs.  These hangs are fixed by changes
in DMCUB firmware for both Rembrandt and Phoenix. Add checks to ensure
that PSR-SU is only enabled when the newer DMCUB firmware is present.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>

Mario Limonciello (4):
  drm/amd/display: Correct `DMUB_FW_VERSION` macro
  drm/amd/display: Set minimum requirement for using PSR-SU on Rembrandt
  drm/amd/display: Set minimum requirement for using PSR-SU on Phoenix
  Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c          |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h          |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h           |  4 +++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c     |  5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h     |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c    |  5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h    |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c       | 11 +++++++----
 .../gpu/drm/amd/display/modules/power/power_helpers.c |  2 --
 10 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.34.1

