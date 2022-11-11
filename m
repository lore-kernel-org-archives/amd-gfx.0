Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12798C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Nov 2022 08:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B5E210E79C;
	Fri, 11 Nov 2022 08:57:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3C310E79C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Nov 2022 08:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm5jAyTfw/eHpxx8md+Wfzc7thvuiklKVXquhI94AUSuXtA5H3GswFG5B/qApId4zwIVN4MYZAwr5pwEg3Lz0nNg8yutmP5obXfzuGoAtkrAYpo6GvahpCRRSlq7xdMYCT3uiD6RFEC+vm9QKP4eIiWqFJ5nu2Hlm/LG+ZDqKnlUp3uRw/KUXSMdTFuR963XLJyEKrevAbBRsboSSCsaNmfZqOY7XoBDXSQjnAJuUy8M31Uzhb01NIHg4sWa5TMOAS6ow5QScXSLtFKfhJ1trHghvWr4lvaA5Tqnqd9sDgxhJYipA65+nUbwmbdqTlv8dIEDvkgvrh0zMo5TzR5JfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSNakRunejqkRy42EKoUjaAsO/2NrUgJPNZXNTATomU=;
 b=UYRoblZSEyQtdqefr9E+s8t7Ab6bSoXbZ4Azcuy7C+P+xk8mtPOAyigotcJ31822m/B9smJwfy0uJQvMeanh4MseczGKfpW2RfsFIgDcO6P1EM3cDfQy5R6PxJ3Xd2/1XEsMca0qP8Dt74QVDqNdOOvLzJDxTbA+GbvHDlLyL1RIBqSYpSM1BjBeI0LDH16jO5KJasQBUhiQusCas3kcrUeeELe6XzhThbcIZjN6iXpBxjF6jSPpR8MryE24BXtqgoczML1G7yigBa0ufz3utQKtPe67OrT3hD+Jey1PWRE0u9FX5GD4PO9NNFKfAzAA9uf6JmSiUWl+dTOWlAJZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSNakRunejqkRy42EKoUjaAsO/2NrUgJPNZXNTATomU=;
 b=Rq8GV+LZ2YqzNSowom8v1yTqoZ+OjUzJyibmHMM1lrAcXJktMVhpViWmxWVBlAZ/swis681HzM7sXe86nsanl8h0O/1uebHrlHznUXx/4nzEfntuMON7UJLkw2yMEH5ZqbDAq/KtQeCbT9l8UOu/0yOpYb4YUpHhjjV0CtxVes0=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 11 Nov
 2022 08:56:58 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::93) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Fri, 11 Nov 2022 08:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 08:56:57 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 02:56:55 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: disable BACO support on more cards
Date: Fri, 11 Nov 2022 16:56:41 +0800
Message-ID: <20221111085641.2264671-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a24838-c6a1-4788-df44-08dac3c2b0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8qMsNGTsyLxKpYalxQBzPj6/VvO9ZcO5D6jF8d6DXIuegyNY0/S1coe44+CrBONvVpZ0WFSqb0qz7FDRyghox+a1PMfX2A6LkOxpW/uB26stdjuLnFzCsOwA5FurwXzgHFKE4/g5hitujffwhljBpU/n3XfDFN/47UqfJv43usrBiyDck0swD0hPsFj10LfHYy+Pl9L+qGwAm7XnqCpl57HJnTi3WDY1HsFMkl3GP5N9qtDGvE5F6feJ2bH1lNjs/CVoAchoXgtpqedGO+i36rKjd9sdAoWyAatEp4vzfDkBVS8nzkmAoLXe8utxdLWKohxVferpVHv+s5iTXv+Aw9nmJA56xhK4ukgV+ifIT5JyEEHJ8ezdrGIfOqX52YfJ6Cp2JcHsZAbF+6k0MQ8ugsZxIkmxb6Aedi0ySq0ysRNstg9fJYsjN7AWroVprrYGY6/5GLC9t7QxNSA8NxA8X/BynXoMbm7sZVdXcMbF4qnflEDoqfN4JmluQKc56goMiiMoZoaI5CrxmkVp7q+Jx2k9ZNt7spTYU7wIYmrPiO9Lu0zIq8+TghQvDrlDLm2JB81sKw336aapT5OXztvpguIRGvDv/JXfPXgbGYWWLh5QRk1CygrUYa76Al3Mo4UsOodscDHesRLxOslb4qscB+jqdhGxYThKwp3zjE/W1c08G0UWzY2jEssJ/pXR7Now1reJv/sTbO8h3WAcv2nLgytZMLDFaYR5nmepuoaaCaHko0O9LvhpsFhQBK/H5bgi98UB5SSQNybAe/MxaZ/QQN0//0dXaR10z2Mmg2NapI6imLR/C0SrNwwVq9ZTl1R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(110136005)(70586007)(82740400003)(4744005)(44832011)(83380400001)(426003)(2906002)(81166007)(36860700001)(478600001)(8676002)(5660300002)(86362001)(356005)(41300700001)(40460700003)(70206006)(47076005)(8936002)(316002)(2616005)(82310400005)(26005)(186003)(4326008)(6636002)(1076003)(7696005)(336012)(6666004)(16526019)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 08:56:57.9602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a24838-c6a1-4788-df44-08dac3c2b0b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise, some unexpected PCIE AER errors will be observed
in runtime suspend/resume cycle.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6212fd270857..697e98a0a20a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -379,6 +379,10 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 		    ((adev->pdev->device == 0x73BF) &&
 		    (adev->pdev->revision == 0xCF)) ||
 		    ((adev->pdev->device == 0x7422) &&
+		    (adev->pdev->revision == 0x00)) ||
+		    ((adev->pdev->device == 0x73A3) &&
+		    (adev->pdev->revision == 0x00)) ||
+		    ((adev->pdev->device == 0x73E3) &&
 		    (adev->pdev->revision == 0x00)))
 			smu_baco->platform_support = false;
 
-- 
2.25.1

